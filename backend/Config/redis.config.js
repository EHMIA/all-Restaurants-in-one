import { configDotenv } from "dotenv";
configDotenv();

const redisOptions={
    host:process.env.REDIS_HOST,
    port:process.env.REDIS_PORT,
    password:process.env.REDIS_PASSWORD,
    tls: {}, 
    maxRetriesPerRequest: null,
};

export default redisOptions;