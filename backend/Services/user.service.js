
// admin or user himself
const getOneUserService = async (id) => {
        const User= await User.findById(id);
        if (!User)
                return null;
        return User;
}
const getAllAdminService = async () => {
        const Admins = await User.find({ role: "admin" });
        if (Admins.length === 0)
                return null;
        return Admins;
};

export 
{
        getOneUserService,
        getAllAdminService
};