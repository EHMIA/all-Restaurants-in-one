import { Settings } from "../Models/adminSettings.model.js";

const handleRestaurantPriceRange=async(restaurant)=>{
        const totalDishs = restaurant.menu.length;
        const totalPrice = restaurant.menu.reduce((total, dish) => total + dish.price, 0);
    
        const avrPrice = totalPrice / totalDishs;
        const settings_=await Settings.findOne();
        if (avrPrice <= settings_.lowMax)
            restaurant.priceRange = "low";
        else if (avrPrice <= settings_.mediumMax)
            restaurant.priceRange = "medium";
        else
            restaurant.priceRange = "high";
    
        return restaurant;
}


const CalculateOpenNow = (restaurant) => {
    const dateNow = new Date(
        new Date().toLocaleString("en-US", { timeZone: "Africa/Cairo" }),
    );

    const Today = Days[dateNow.getDay()];
    const hourNow = dateNow.getHours();
    const minuteNow = dateNow.getMinutes();
    const TimeNow = hourNow * 60 + minuteNow;

    const todayHours = restaurant.openingHours.find((OPH) => OPH.day === Today);

    if (
        !todayHours ||
        todayHours.isClosed ||
        !todayHours.opens ||
        !todayHours.closes
    ) {
        return false;
    }

    const [openH, openM] = todayHours.opens.split(":").map(Number);
    const [closeH, closeM] = todayHours.closes.split(":").map(Number);

    let openingTime = openH * 60 + openM;
    let closingTime = closeH * 60 + closeM;

    if (closingTime <= openingTime) {
        if (TimeNow < closingTime) {
            return true;
        }

        closingTime += 24 * 60;
    }

    return TimeNow >= openingTime && TimeNow < closingTime;
};

export {handleRestaurantPriceRange, CalculateOpenNow};