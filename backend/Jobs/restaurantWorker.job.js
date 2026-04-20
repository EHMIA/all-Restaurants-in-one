import { Worker } from "bullmq";
import { restaurantModel } from "../Models/restaurant.model.js";
import { handleRestaurantPriceRange } from "../Utils/handleRestaurantData.util.js";
import redisOptions from "../Config/redis.config.js";


export const worker= new Worker("restaurantQueue",async(job)=>{
    if(job.name==="recalculate-prices"){
        const {lowMax,mediumMax}=job.data;

        const restaurants=await restaurantModel.find({});
        for(const restaurant of restaurants){
            await handleRestaurantPriceRange(restaurant);
            await restaurant.save();
        }
    }
},{
    connection:redisOptions,
});

