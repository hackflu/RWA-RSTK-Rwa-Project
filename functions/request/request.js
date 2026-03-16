require("dotenv").config();
const requestConfig = require("../config/alpacaConfig.js");
const {simulateScript , decodeResult} = require("@chainlink/functions-toolkit");

async function main() {
    const { responseBytesHexstring, errorString, capturedTerminalOutput } = await simulateScript({
        source: requestConfig.source,
        args: requestConfig.args,
        secrets: requestConfig.secrets    
    });
    console.log("=== Terminal Output ===");
    if(responseBytesHexstring){
        console.log("Response (hexstring) : ", decodeResult(responseBytesHexstring, requestConfig.expectedReturnType).toString());
    }
    if(errorString){
        console.log("Error : ", errorString);
    }
}

main().catch((error)=>{
    console.log(error);
    process.exitCode = 1
})
