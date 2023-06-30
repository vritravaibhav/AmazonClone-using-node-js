const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
//  authRouter.get("/user", (req,res)=>{
//     res.json({msg:"rivaan"});

//  })
authRouter.post("/api/signup", async (req, res) => {

    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({
            email
        });

        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist" });
        }

        const hashedpassword = await bcrypt.hash(password, 8);

        let user = new User({
            email,

            password: hashedpassword,
            name
        })


        user = await user.save();
        console.log("goodies");
        res.status(200).json(user);

    } catch (e) {
        // console.log("good");
        res.status(500).json({error: e.message,});
    }
});
    authRouter.post("/api/signin", async (req, res) => {
        try {
           //  console.log("goodies");
            const { email, password } = req.body;
            const user =await  User.findOne({email});
            if (!user) {
                return res.status(400).json({ message: "Account with that email does not exist" });
            }
            const isMatched =await  bcrypt.compare(password, user.password);

            if (!isMatched) {
               return  res.status(400).json({ message: "Your password is wrong eh eh eheh" });
            }

            const token = jwt.sign({ id: user._id }, "passwordkey");
           res.json({ token, ...user._doc });
           // res.json(user);
          
            //res.status(200).json({message:"Successfully login"});
            
        } catch (e) {
            res.status(500).json({ error: e.message });
           
           
        }
    });



    authRouter.post("/tokenIsValid",async (req, res)=>{
       try {
        const token = req.header('x-auth-token');
        if(!token){
            return res.json(false);
        
          }
          const isverified =   jwt.verify(token,"passwordKey");
          if(!isverified){
            return res.json(false);
        }

            //problem could lies here
            const user = await User.findById(isverified.id);
            if(!user){
                return res.json(false);

            }
            return res.json(true);

       } catch (e) {
        res.status(500).json({error:e.message});
       }
    });

    //get user data
    authRouter.get("/", auth,async (req,res)=>{
        const user = await User.findById(req.user);
        res.json({...user._doc,token:req.token});
    });



module.exports = authRouter;