from flask import Flask, render_template_string
from pyghmi.ipmi import command
import pynvml

app = Flask(__name__)

def get_ipmi_temp():
    try:
        cmd = command.Command()
        readings = cmd.get_sensor_data()
        for reading in readings:
            if reading.name == 'System Temp':
                return f"{reading.value} {reading.units}"
    except Exception as e:
        return f"Error getting IPMI temperature: {str(e)}"

def get_nvidia_temp():
    try:
        pynvml.nvmlInit()
        handle = pynvml.nvmlDeviceGetHandleByIndex(0)
        temp = pynvml.nvmlDeviceGetTemperature(handle, pynvml.NVML_TEMPERATURE_GPU)
        pynvml.nvmlShutdown()
        return f"{temp}°C"
    except Exception as e:
        return f"Error getting NVIDIA temperature: {str(e)}"

@app.route('/')
def index():
    ipmi_temp = get_ipmi_temp()
    nvidia_temp = get_nvidia_temp()
    
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Temperature Monitor</title>
    </head>
    <body>
        <h1>Temperature Monitor</h1>
        <p>IPMI Temperature: {{ ipmi_temp }}</p>
        <p>NVIDIA GPU Temperature: {{ nvidia_temp }}</p>
    </body>
    </html>
    """
    return render_template_string(html, ipmi_temp=ipmi_temp, nvidia_temp=nvidia_temp)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
