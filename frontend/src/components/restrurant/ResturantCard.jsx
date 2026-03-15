const RestaurantCard = ({ restaurant }) => {
    return (
        <div className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition-shadow">
            <img
                src={restaurant.image}
                alt={restaurant.name}
                className="w-full h-44 object-cover"
            />
            <div className="p-4">
                <h3 className="font-bold text-lg">{restaurant.name}</h3>

                <div className="flex items-center mt-1 text-sm text-gray-600">
                    <span className="text-yellow-500 font-bold">★ {restaurant.rating}</span>
                    <span className="mx-1">•</span>
                    <span>{restaurant.reviews} تقييم</span>
                </div>

                <div className="text-sm text-gray-600 mt-1">
                    {restaurant.cuisine} • {restaurant.distance}
                </div>

                <div className="mt-2 flex items-center justify-between">
                    <span className="text-sm font-medium">{restaurant.price}</span>
                    <span className={`text-sm font-medium ${restaurant.isOpen ? 'text-green-600' : 'text-red-600'}`}>
                        {restaurant.isOpen ? 'مفتوح' : 'مغلق'}
                    </span>
                </div>
            </div>
        </div>
    );
};

export default RestaurantCard;