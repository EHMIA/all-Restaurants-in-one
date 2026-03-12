import asyncHandler from "express-async-handler"
import { restaurantModel } from "../Models/restaurant.model";
import { PriceRanges } from "../Utils/Constants";

// public
const  getAllRestaurants = asyncHandler(async(req,res)=>{
    let {Page , Limit ,priceRange, rating ,delivery, cuisineType }= req.query;
    Page= parseInt(Page)|| 1;
    Limit=parseInt(Limit) || 10;
    const Skip=(Page-1)*Limit;
    const PriceValidation=PriceRanges;
    const DeliveryEnum=["true","false"];
    const Conditions={};

    if (rating) {
        const rating_av = parseFloat(rating);
        if(isNaN(rating_av) || rating_av>5 || rating_av<0){
            return res.status(400).json({ message: "Rating is limited between 0 to 5" })
        }else{
            Conditions.rating={$gte:rating_av};
        }
    }
    if(delivery) {
        if(!DeliveryEnum.includes(delivery.toLowerCase())){
            return res.status(400).json({message:"Delivery must be true or false"});
        }else{
            Conditions.delivery=delivery==="true";
        }
    }
    if(cuisineType)Conditions.cuisineType={$in:cuisineType};
    if(priceRange) {
        if(!PriceValidation.includes(priceRange.toLowerCase())){
            return res.status(400).json({message: "PriceRange must be low, medium or high"} );
        }else{
            Conditions.priceRange=priceRange;
        }
    }
    const [restaurants,totalResNumber]=await Promise.all([
        restaurantModel.find(Conditions).skip(Skip).limit(Limit),
        restaurantModel.countDocuments(Conditions)
    ]);

    const pagesCount= Math.ceil(totalResNumber/Limit);
    res.status(200).json({
        data:restaurants,
        meta:{
            totalResNumber, // restaurant number
            pagesCount, // pages counter
            Page, // page number
            Limit
        }
    })
});


// public
const getOneRestaurant= asyncHandler(async(req,res)=>{
    const Restaurant= await restaurantModel.findById(req.params.id);
    if(!Restaurant)
        return res.status(404).json({message:"Restaurant not found" })
    res.status(200).json(Restaurant);
});


// for admin or user=>to owner
const createNewRestaurant= asyncHandler(async(req,res)=>{
    
})


