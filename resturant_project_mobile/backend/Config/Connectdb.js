import { connect } from "mongoose"

export async  function ConnectDB(){
    try {
        await connect(process.env.MONGO_URI);
        console.log(`Server running on PORT ${process.env.PORT}`);
        
    } catch (error) {
        console.log(`ERROR ${error}`);
        
    }
}
