const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
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
        res.status(500).json({
            error: e.message,

        });
    }
    authRouter.post("/api/signin", async (req, res) => {
        try {
            const { email, password } = req.body;
            const user =await  User.findOne({email});
            if (!user) {
                return res.status(400).json({ message: "Account with that email does not exist" });
            }
            const isMatched =await  bcrypt.compare(password, user.password);

            if (!isMatched) {
               return  res.status(400).json({ message: "Your password is wrong eh eh eheh" });
            }

            const token = jwt.sign({ id: user._id }, "password key");
           res.json({ token, ...user._doc });
            res.json(user);

            //res.status(200).json({message:"Successfully login"});
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    })


})
module.exports = authRouter;