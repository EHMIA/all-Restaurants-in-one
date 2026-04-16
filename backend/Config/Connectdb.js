import mongoose from 'mongoose';

const { connect, connection } = mongoose;
export async function ConnectDB() {
    mongoose.set('bufferCommands', false);
    if(connection.readyState === 1) return;
    if (connection.readyState===2) 
    {
        console.log("DB is already connecting...");
        return;
    }

    try {
        await connect(process.env.MONGO_URI,{
            serverSelectionTimeoutMS: 5000, 
            socketTimeoutMS: 45000,
        });
        console.log("Connected to MongoDB successfully!");
        
    } catch (error) {
        console.error(`ERROR connecting to MongoDB: ${error}`);
    }
}