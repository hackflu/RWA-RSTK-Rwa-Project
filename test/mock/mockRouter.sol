// test/mocks/MockFunctionsRouter.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract mockRouter {
    struct Request {
        address sender;
        bytes data;
    }
    
    mapping(bytes32 => Request) public requests;

    function sendRequest(
        uint64 subscriptionId,
        bytes calldata data,
        uint16 dataVersion,
        uint32 callbackGasLimit,
        bytes32 donId
    ) external returns (bytes32) {
        bytes32 requestId = keccak256(abi.encodePacked(block.timestamp, subscriptionId));
        requests[requestId] = Request(msg.sender, data);
        return requestId;
    }

    function fulfillRequest(address consumer, bytes32 requestId, bytes memory response, bytes memory err) external {
        (bool success, ) = consumer.call(
            abi.encodeWithSignature("handleOracleFulfillment(bytes32,bytes,bytes)", requestId, response, err)
        );
        require(success, "Fulfillment failed");
    }
}