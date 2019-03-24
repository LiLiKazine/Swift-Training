
//
//  ChatRoom.swift
//  DogeChat
//
//  Created by LiLi Kazine on 2019/3/24.
//  Copyright © 2019 Luke Parham. All rights reserved.
//

import UIKit

protocol ChatRoomDelegate: class {
    func receivedMessage(message: Message)
}

class ChatRoom: NSObject {
    
    weak var delegate: ChatRoomDelegate?
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var username = ""
    
    let maxReadLength = 4096
//
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 80, &readStream, &writeStream)
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        inputStream.delegate = self
        inputStream.schedule(in: .current, forMode: .commonModes)
        outputStream.schedule(in: .current, forMode: .commonModes)
        inputStream.open()
        outputStream.open()
        
    }

    func joinChat(username: String) {
        let data = "iam: \(username)".data(using: .ascii)!
        self.username = username
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }

    func sendMessage(message: String) {
        let data = "msg:\(message)".data(using: .ascii)!
        
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    
    func stopChatSession() {
        inputStream.close()
        outputStream.close()
    }

}

extension ChatRoom: StreamDelegate {
//
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {

//        print("\(Stream.Event.openCompleted): openCompleted")
//        print("\(Stream.Event.hasBytesAvailable): hasBytesAvailable")
//        print("\(Stream.Event.hasSpaceAvailable): hasSpaceAvailable")
//        print("\(Stream.Event.errorOccurred): errorOccurred")
//        print("\(Stream.Event.endEncountered): endEncountered")

        
        switch eventCode {
        case Stream.Event.openCompleted:
            print("complete")
        case Stream.Event.hasBytesAvailable:
            readAvailableBytes(stream: aStream as! InputStream)
            print("new message received")
        case Stream.Event.endEncountered:
            stopChatSession()

            print("new message received")
        case Stream.Event.errorOccurred:
            
            print("error occurred")
        case Stream.Event.hasSpaceAvailable:
            print("has space available")
        default:

            print("\(eventCode.rawValue): some other event...")
            break
        }
        
       
    }

    private func readAvailableBytes(stream: InputStream) {

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        
        while stream.hasBytesAvailable {

            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            
            if numberOfBytesRead < 0 {
                if let _ = stream.streamError {
                    break
                }
            }
            
            if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                delegate?.receivedMessage(message: message)
            }
        }
    }

    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> Message? {

        guard let stringArray = String(bytesNoCopy: buffer,
                                       length: length,
                                       encoding: .ascii,
                                       freeWhenDone: true)?.components(separatedBy: ":"),
            let name = stringArray.first,
            let message = stringArray.last else {
                return nil
        }
        //2
        let messageSender: MessageSender = (name == self.username) ? .ourself : .someoneElse
        //3
        return Message(message: message, messageSender: messageSender, username: name)
    }

    
}
