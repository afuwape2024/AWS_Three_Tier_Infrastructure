const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.json({
        service: "order-service",
        status: "running",
        version: "1.0.0"
    });
});

app.get("/orders", (req, res) => {
    res.json([
        { id: 1001, customer: "Alice Johnson", total: 250.75, status: "Processing" },
        { id: 1002, customer: "Bob Smith", total: 99.99, status: "Shipped" },
        { id: 1003, customer: "Carol Davis", total: 500.00, status: "Delivered" }
    ]);
});

app.listen(4000, "0.0.0.0", () => {
    console.log("order-service running on port 4000");
});