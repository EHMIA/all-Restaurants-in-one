
// admin or user himself
const getOneUserService = async (id) => {
        return await User.findById(id);
}
const getAllAdminService = async () => {
        return await User.find({ role: "admin" });
};

export 
{
        getOneUserService,
        getAllAdminService
};