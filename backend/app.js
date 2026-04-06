import { ConnectDB } from "./Config/Connectdb.js"
import {configDotenv} from "dotenv"
import express, { json } from "express"

const app=express();

app.use(json());
app.use("")
app.use()
configDotenv();
ConnectDB();


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server on port ${PORT}`));