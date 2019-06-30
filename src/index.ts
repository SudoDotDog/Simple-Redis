import * as Express from "express";

const app: Express.Express = Express();
const port: number = 3000

app.get('/', (req: Express.Request, res: Express.Response) => {
    res.send('Hello World!');
});

app.listen(port, () => console.log(`Listening on port ${port}!`));
