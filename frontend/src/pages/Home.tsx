import { Link } from 'react-router-dom'
import RestaurantCard from '../components/restaurant/RestaurantCard'

const restaurants = [
    {
        id: 1,
        name: 'Restaurant 1',
        image: 'https://via.placeholder.com/150',
        rating: 4.5,
        cuisine: 'Italian',
        price: '$$',
        location: 'New York, NY',
        distance: '2 miles',
        isOpen: true,
    },
    {
        id: 2,
        name: 'Restaurant 2',
        image: 'https://via.placeholder.com/150',
        rating: 4.0,
        cuisine: 'Mexican',
        price: '$',
        location: 'Los Angeles, CA',
        distance: '5 miles',
        isOpen: false,
    },
    {
        id: 3,
        name: 'Restaurant 3',
        image: 'https://via.placeholder.com/150',
        rating: 4.2,
        cuisine: 'Chinese',
        price: '$$$',
        location: 'Chicago, IL',
        distance: '3 miles',
        isOpen: true,
    },
]

const categories = [
    { id: 1, name: 'Italian', image: 'https://via.placeholder.com/100' },
    { id: 2, name: 'Mexican', image: 'https://via.placeholder.com/100' },
    { id: 3, name: 'Chinese', image: 'https://via.placeholder.com/100' },
    { id: 4, name: 'Indian', image: 'https://via.placeholder.com/100' },
    { id: 5, name: 'Thai', image: 'https://via.placeholder.com/100' },
]


const Home = () => {
    return (
        <div className="min-h-screen bg-gray-50">
            {/* Header */}
            <header className="sticky top-0 z-10 bg-white shadow-sm">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex items-center justify-between">
                    <Link to="/" className="text-2xl font-bold text-orange-600">
                        Akiel
                    </Link>

                    <div className="flex-1 max-w-xl mx-8">
                        <input
                            type="text"
                            placeholder="ابحث عن مطعم أو طبق..."
                            className="w-full px-5 py-3 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent"
                        />
                    </div>

                    <div className="flex items-center gap-4">
                        <Link
                            to="/login"
                            className="px-4 py-2 text-gray-700 hover:text-orange-600"
                        >
                            تسجيل الدخول
                        </Link>
                        <Link
                            to="/register"
                            className="px-5 py-2 bg-orange-600 text-white rounded-full hover:bg-orange-700 transition"
                        >
                            إنشاء حساب
                        </Link>
                    </div>
                </div>
            </header>

            {/* Hero / Search hint */}
            <section className="bg-linear-to-r from-orange-500 to-orange-600 text-white py-16">
                <div className="max-w-4xl mx-auto px-4 text-center">
                    <h1 className="text-4xl md:text-5xl font-bold mb-4">
                        اكتشف أفضل المطاعم حولك
                    </h1>
                    <p className="text-xl md:text-2xl opacity-90 mb-8">
                        آلاف المطاعم – منيوهات – تقييمات حقيقية
                    </p>
                </div>
            </section>

            {/* Categories */}
            <section className="py-8 border-b">
                <div className="max-w-7xl mx-auto px-4">
                    <h2 className="text-2xl font-bold mb-6 text-center md:text-right">
                        تصفح حسب النوع
                    </h2>
                    <div className="flex flex-wrap gap-3 justify-center md:justify-start">
                        {categories.map((cat) => (
                            <button
                                key={cat.id}
                                className="px-6 py-2.5 bg-white border border-gray-300 rounded-full text-sm font-medium hover:bg-orange-50 hover:border-orange-300 transition"
                            >
                                {cat.name}
                            </button>
                        ))}
                    </div>
                </div>
            </section>

            {/* Featured / Popular Restaurants */}
            <section className="py-12">
                <div className="max-w-7xl mx-auto px-4">
                    <h2 className="text-2xl md:text-3xl font-bold mb-8 text-center md:text-right">
                        المطاعم المميزة
                    </h2>

                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                        {restaurants.map((res) => (
                            <RestaurantCard key={res.id} restaurant={res} />
                        ))}
                    </div>
                </div>
            </section>

            {/* Footer بسيط */}
            <footer className="bg-gray-900 text-gray-300 py-8">
                <div className="max-w-7xl mx-auto px-4 text-center">
                    <p>© {new Date().getFullYear()} Akiel - كل الحقوق محفوظة</p>
                    <div className="mt-4 flex justify-center gap-6">
                        <Link to="/about" className="hover:text-white">من نحن</Link>
                        <Link to="/contact" className="hover:text-white">تواصل معنا</Link>
                        <Link to="/terms" className="hover:text-white">الشروط والأحكام</Link>
                    </div>
                </div>
            </footer>
        </div>
    )
}

export default Home