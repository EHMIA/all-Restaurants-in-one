import { ConnectDB } from "./Config/Connectdb.js"
import {configDotenv} from "dotenv"
import express, { json } from "express"

const app=express();

app.use(json());

configDotenv();
ConnectDB();