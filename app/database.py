from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy import Column, Integer, Float, DateTime, String
from datetime import datetime, UTC
import asyncio

DATABASE_URL = "postgresql+asyncpg://postgres:yourpassword@db:5432/tempman"

engine = create_async_engine(DATABASE_URL, echo=True)
AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

Base = declarative_base()

class TemperatureReading(Base):
    __tablename__ = "temperature_readings"

    id = Column(Integer, primary_key=True, index=True)
    device = Column(String, index=True)
    temperature = Column(Float)
    timestamp = Column(DateTime, default=lambda: datetime.now(UTC))

async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

async def get_db():
    async with AsyncSessionLocal() as session:
        yield session

async def test_db_connection():
    try:
        async with engine.connect() as conn:
            result = await conn.execute("SELECT 1")
            print("Database connection successful!")
    except Exception as e:
        print(f"Database connection failed: {e}")

if __name__ == "__main__":
    asyncio.run(test_db_connection())
