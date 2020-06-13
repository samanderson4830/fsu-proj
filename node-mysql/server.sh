#!/usr/bin/env bash


export BSA_USER='root'
export BSA_PWD='Pass12345'
export BSA_HOST='localhost'
export BSA_DB='BSA_Database'
export BSA_PORT=3000

npm install
nodemon server.js
