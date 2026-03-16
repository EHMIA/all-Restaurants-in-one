import { restaurantModel } from "../Models/restaurant.model";


const getAllRestaurantsService = async (conditions, skip, limit) => {
    const [restaurants, totalResNumber] =await Promise.all([
        restaurantModel.find(conditions).skip(skip).limit(limit),
        restaurantModel.countDocuments(conditions)
    ]);
    return [restaurants, totalResNumber];
}


const getOneRestaurantService =async(id)=>{
    const Restaurant = await restaurantModel.findById(id);
    return Restaurant;
}

// just admins
const updateRestaurantStatus=async(id,status,AdminId,reason=null)=>{
    //remember=>  here check if it is pedning if there are endPoint for change restaurant status
    const updateData = {
        status,
        [`${status}At`]: new Date(),
        [`${status}By`]: AdminId
    };
    if(reason) updateData.rejectionReason=reason;

    const Restaurant = await restaurantModel.findByIdAndUpdate(id,
        {
            updateData
        },
        {
            new: true,
            runValidators: true
        }
    );
    return Restaurant;
}

export{
    getAllRestaurantsService,
    getOneRestaurantService,
    updateRestaurantStatus
}
