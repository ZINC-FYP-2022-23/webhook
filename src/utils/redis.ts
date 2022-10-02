import * as dotenv from "dotenv";
import Redis from "ioredis";
dotenv.config();

const redis = new Redis(parseInt(process.env.REDIS_PORT, 10) || 6379, process.env.REDIS_HOST ?? '127.0.0.1');

export default redis;