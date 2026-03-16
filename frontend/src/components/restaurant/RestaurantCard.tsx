import { Link } from 'react-router-dom';

interface Restaurant {
    id: number;
    name: string;
    image: string;
    rating: number;
    cuisine: string;
    price: string;
    location: string;
    distance: string;
    isOpen: boolean;
}

interface Props {
    restaurant: Restaurant;
}

export default function RestaurantCard({ restaurant }: Props) {
    return (
        <Link
            to={`/restaurant/${restaurant.id}`}
            className="block bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition-shadow duration-300"
        >
            <div className="relative">
                <img
                    src={restaurant.image}
                    alt={restaurant.name}
                    className="w-full h-48 object-cover"
                />
                <div
                    className={`absolute top-3 right-3 px-3 py-1 rounded-full text-xs font-bold ${restaurant.isOpen ? 'bg-green-500 text-white' : 'bg-red-500 text-white'
                        }`}
                >
                    {restaurant.isOpen ? 'مفتوح' : 'مغلق'}
                </div>
            </div>

            <div className="p-4">
                <h3 className="font-bold text-lg mb-1 truncate">{restaurant.name}</h3>

                <div className="flex items-center text-sm text-gray-600 mb-2">
                    <span className="text-yellow-500 font-bold">★ {restaurant.rating}</span>
                    <span className="mx-2">•</span>
                    <span>{restaurant.cuisine}</span>
                </div>

                <div className="text-sm text-gray-500">
                    {restaurant.distance}
                </div>
            </div>
        </Link>
    );
}