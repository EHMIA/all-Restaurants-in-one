// constansts used in the project

const Days = [
    'sunday','monday', 'tuesday', 'wednesday', 'thursday',
    'friday', 'saturday'
];

const CuisineTypes = [
    "Egyptian", "Lebanese", "Syrian", "Moroccan", "Khaleeji",
    "Italian", "Chinese", "Japanese", "Indian", "Mexican",
    "American", "French", "Turkish", "Greek",
    "FastFood", "Seafood", "Grills", "Pizza", "Burgers",
    "Sushi", "Sandwiches", "Desserts", "Healthy", "Vegan",
    "Breakfast", "Cafe"
];

const MenuCategories = [
    'Appetizers', 'Salads', 'Soups', 'Main Courses',
    'Grills', 'Shawarma', 'Pasta', 'Pizza',
    'Burgers & Sandwiches', 'Rice Dishes', 'Vegetarian',
    'Sides', 'Desserts', 'Beverages'
];

const PriceRanges = ["low", "medium", "high"];
const RestaurantStatuses = ["pending", "approved", "rejected"];

const LIMITS = {
    MENU_ITEMS: 10,
    GALLERY_PHOTOS: 40,
    BRANCHES: 5,
    CUISINE_TYPES: 5,
    NAME_MIN: 3,
    NAME_MAX: 50,
};

export  { Days, CuisineTypes, MenuCategories, PriceRanges, RestaurantStatuses, LIMITS };