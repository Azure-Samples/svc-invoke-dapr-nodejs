# Dapr Service Invocation 

In this quickstart, you'll create two microservices that communivate using Dapr's service invocation API. With Dapr’s Service Invocation API, your application can communicate reliably and securely with other applications.

![](images/service-invocation-quickstart.png)

Visit [this](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/) link for more information about Dapr and Service Invocation.

# Run and develop locally

### Run the Javascript order-processor service (callee) with Dapr

2. Open a new terminal window, change directories to `./order-processor` in the quickstart directory and run: 

```bash
cd ../order-processor
npm install
```

3. Run the Javascript order-processor service (callee) app with Dapr: 

```bash
dapr run --app-port 5001 --app-id order-processor --app-protocol http --dapr-http-port 3501 -- npm start
```

### Run the Javascript checkout service (caller) with Dapr

2. Open a new terminal window, change directories to `./checkout` in the quickstart directory and run: 

```bash
cd ../checkout
npm install
```

3. Run the Javascript checkout service (callee) app with Dapr: 

```bash
dapr run  --app-id checkout --app-protocol http --dapr-http-port 3500 -- npm start
```

4. Expected output:
In both terminals, you will see orders passed and orders received. Service invocation requests are made from the checkout service to the order-processor service: 

From the checkout service:
```bash
== APP == Order passed: {"orderId":1}
== APP == Order passed: {"orderId":2}
== APP == Order passed: {"orderId":3}
== APP == Order passed: {"orderId":4}
```

From the order-processor service:
```bash
== APP == Order received: { orderId: 1 }
== APP == Order received: { orderId: 2 }
== APP == Order received: { orderId: 3 }
== APP == Order received: { orderId: 4 }
```

# Deploy to Azure (Azure Container Apps)
Deploy to Azure for dev-test

> NOTE: make sure you have Azure Dev CLI pre-reqs [here](https://github.com/Azure-Samples/todo-python-mongo-aca)

1. Provision infra and deploy application:
```bash
azd up
```

2. Confirm the deployment is susccessful:

Navigate to the Container App resource for the Batch service. Locate the `Log stream` and confirm the batch container is logging each insert successfully every 10s. 

![](images/log_stream.png)

