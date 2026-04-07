import { connect, connection } from "mongoose";

export async function ConnectDB() {
    // check if we are already connected        
    if (connection.readyState >= 1) {
        return;
    }

    try {
        await connect(process.env.MONGO_URI);
        console.log("Connected to MongoDB successfully!");
    } catch (error) {
        console.error(`ERROR connecting to MongoDB: ${error}`);
    }
}