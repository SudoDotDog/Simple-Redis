/**
 * @author WMXPY
 * @namespace Redis
 * @description Index
 */

import * as Express from "express";
import * as Redis from "redis";

const app: Express.Express = Express();
const port: number = 8080;

const redis: Redis.RedisClient = Redis.createClient(6379, 'localhost');

app.get('/set', (_: Express.Request, res: Express.Response) => {
    redis.set('color', 'red');
    res.send('Hello World!');
});

app.get('/get', async (_: Express.Request, res: Express.Response) => {

    redis.get('color', (err, color) => {
        res.send(color);
    });
});

app.listen(port, () => console.log(`Listening on port ${port}!`));
