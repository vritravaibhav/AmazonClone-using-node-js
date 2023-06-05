
const   express = require("express");
const mongoose = require('mongoose');
const authRouter = require("./routes/auth");


// import 
const PORT = 3000;
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);


mongoose.connect('mongodb+srv://vritravaibhav:vaibhav@cluster0.iyo3uo5.mongodb.net/?retryWrites=true&w=majority').then(()=>{
    console.log('Connection Successfully eastablished');
}).catch((e)=>{
    console.log(e);
    //console.log("good");
})


app.listen(PORT,"0.0.0.0",function(){
    console.log(`connected at port ${PORT} `);
});
//mongodb+srv://vritravaibhav:<password>@cluster0.iyo3uo5.mongodb.net/?retryWrites=true&w=majority
