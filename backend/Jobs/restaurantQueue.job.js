import redisOptions from "../Config/redis.config.js";
import { Queue } from "bullmq";

const restaurantQueue = new Queue("restaurantQueue", {
    connection: redisOptions
});

const addRecalculatePricesJob=async(adminSetings)=>{
        await restaurantQueue.add('recalculate-prices', settingsData);
}

export {
    addRecalculatePricesJob
}