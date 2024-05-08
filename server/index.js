const express = require('express');
const { Server } = require('ws');
const { initializeApp, applicationDefault, cert} = require('firebase-admin/app');
const  { getFirestore, Timestamp, FieldValue, Filter } = require('firebase-admin/firestore');
const serviceAccount = require("./serviceAccountKey.json");
const { heartbeat, generateID, putUser, get, put, send, handleFriendrequest, saveRoute, respondRequest, disconnectUser } = require('./helper');

// Initializing database variables


// Initialize server variable

const PORT = process.env.PORT || 3000;
const server = express().use((req, res) => res.send("HELLO WORLD")).listen(PORT, () => console.log(`listening to port: ${PORT}`));
const wss = new Server({server});

wss.connectedUsers = [];

let i = 0;
// Event handler


// TODO: create one dynamic send and dynamic get function.
// TODO: create a sorting function for 
wss.on('connection', ws => {
    ws.id = generateID();

    // inform client of their id
    ws.send(JSON.stringify({
        msgID: "init",
        socketID: ws.id,
        signature: 0, 
    }));
    i++;
    console.log('Client connected: ', ws.id);

    ws.on('message', function inc(data) {
        let message =  data;

        message = JSON.parse(message);
        console.log('i = ', i);
        console.log('1: ', message);
        console.log('2: ', message.data);
        switch(message.msgID) {
            case "initRes":
                putUser(message.data.username, message.data);
                console.log('=== user added to database ===');
                wss.connectedUsers.push({"username": message.data.username, "socket": ws, "id": ws.id});
                break;
            case "getLeaderboard":
                send(ws, 'leaderboard');
                console.log('sent leaderboard');
                break;
            case "addFriend":
                handleFriendrequest(ws, message.data.sender, message.data.target, wss.connectedUsers)
                console.log('sent friend request');
                break;
            case "acceptRequest":
                respondRequest(ws, message.data.target, message.data.sender, true, wss.connectedUsers);
                break;
            case "rejectRequest":
                respondRequest(ws, message.data.target, message.data.sender, false, wss.connectedUsers);
                break;
            
                
        }
    })

    ws.on('close', async () => {
        console.log(`Client with id: ${ws.id} has disconnected.`);
        console.log('before dc:', wss.connectedUsers);
        wss.connectedUsers = await disconnectUser(ws.id, wss.connectedUsers);
        console.log('after dc:', wss.connectedUsers);
    });

});