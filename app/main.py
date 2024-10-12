import asyncio
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Dict
import uvicorn
import subprocess
import json
from database import init_db, get_db, TemperatureReading
from sqlalchemy.future import select

app = FastAPI()

# ... (keep the existing CORS middleware and other imports)

# Add these new imports
import GPUtil
from pyipmi import create_connection
from pyipmi.bmc import LanBMC

# IPMI configuration (replace with your actual IPMI details)
IPMI_HOST = '192.168.1.100'
IPMI_USER = 'admin'
IPMI_PASSWORD = 'password'

# Initialize IPMI connection
ipmi_conn = create_connection(LanBMC(IPMI_HOST, IPMI_USER, IPMI_PASSWORD))

async def get_ipmi_temperature():
    try:
        ipmi_conn.open()
        sensor_reading = ipmi_conn.get_sensor_reading(0)  # Assuming sensor ID 0 is temperature
        ipmi_conn.close()
        return sensor_reading.value
    except Exception as e:
        print(f"Error getting IPMI temperature: {e}")
        return None

async def get_gpu_temperatures():
    try:
        gpus = GPUtil.getGPUs()
        return {f"gpu{i}": gpu.temperature for i, gpu in enumerate(gpus)}
    except Exception as e:
        print(f"Error getting GPU temperatures: {e}")
        return {}

async def monitor_temperatures():
    while True:
        ipmi_temp = await get_ipmi_temperature()
        gpu_temps = await get_gpu_temperatures()

        async with AsyncSessionLocal() as session:
            if ipmi_temp is not None:
                session.add(TemperatureReading(device="ipmi", temperature=ipmi_temp))

            for gpu, temp in gpu_temps.items():
                session.add(TemperatureReading(device=gpu, temperature=temp))

            await session.commit()

        await adjust_fan_speeds()
        await asyncio.sleep(5)

async def adjust_fan_speeds():
    # Simple example: adjust case fan based on max temperature
    max_temp = max(max(temps[-1] if temps else 0) for temps in temp_data.values())
    if max_temp > 70:
        fan_speeds["case"] = 100
    elif max_temp > 60:
        fan_speeds["case"] = 75
    elif max_temp > 50:
        fan_speeds["case"] = 50
    else:
        fan_speeds["case"] = 25

    # Implement GPU-specific fan control here

@app.on_event("startup")
async def startup_event():
    await init_db()
    asyncio.create_task(monitor_temperatures())

@app.get("/temperatures")
async def get_temperatures(db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        select(TemperatureReading).order_by(TemperatureReading.timestamp.desc()).limit(100)
    )
    readings = result.scalars().all()
    return {reading.device: reading.temperature for reading in readings}

# ... (keep the existing FastAPI routes)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
