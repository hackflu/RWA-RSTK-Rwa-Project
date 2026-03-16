if(!secrets.alpacaApiKey && !secrets.alpacaSecretKey){
    throw Error(
        "ALPACA API_KEY and SECRET_KEY must be provided"
    );
}

const alpacaRequest = Functions.makeHttpRequest({
    url:`https://data.alpaca.markets/v2/stocks/RSST/trades/latest`,
    headers: { // API keys should be in the 'headers' object
        'APCA-API-KEY-ID': secrets.alpacaApiKey,
        'APCA-API-SECRET-KEY': secrets.alpacaSecretKey,
    },
})

const AlpacaResponse = await alpacaRequest;
console.log("Data:", JSON.stringify(AlpacaResponse.data["trade"]["p"]));
if(AlpacaResponse.error){
    throw new Error("Alpaca Error : " + AlpacaResponse.error.message);
}


const price = JSON.stringify(AlpacaResponse.data["trade"]["p"]);
return Functions.encodeUint256(Math.round(price * 1e8));

