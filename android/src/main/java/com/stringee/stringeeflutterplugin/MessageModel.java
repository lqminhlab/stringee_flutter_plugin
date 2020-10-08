package com.stringee.stringeeflutterplugin;

//public static final int TYPE_TEXT = 1;
//public static final int TYPE_PHOTO = 2;
//public static final int TYPE_VIDEO = 3;
//public static final int TYPE_AUDIO = 4;
//public static final int TYPE_FILE = 5;
//public static final int TYPE_LINK = 6;
//public static final int TYPE_CREATE_CONVERSATION = 7;
//public static final int TYPE_RENAME_CONVERSATION = 8;
//public static final int TYPE_LOCATION = 9;
//public static final int TYPE_CONTACT = 10;
//public static final int TYPE_STICKER = 11;
//public static final int TYPE_NOTIFICATION = 100;
//public static final int TYPE_TEMP_DATE = 1000;

//State
//INITIALIZE(0),
//SENDING(1),
//SENT(2),
//DELIVERED(3),
//READ(4);

import com.stringee.messaging.Message;

public class MessageModel {
    String id;
    String creator;
    String conversation;
    String message;
    Long timeCreated;
    Message.State state;

    public MessageModel(String id, String creator, String conversation, String message, Long timeCreated, Message.State state){
        this.id = id;
        this.creator = creator;
        this.conversation = conversation;
        this.message = message;
        this.timeCreated = timeCreated;
        this.state = state;
    }
}
