package com.stringee.stringeeflutterplugin;

import com.stringee.messaging.User;

import java.util.List;

public class ConversationModel {
    String id;
    String creator;
    String name;
    List<User> participants;
    Long timeCreated;
    String lastMessage;
    long lastTime;
    int state;
    int unread;

    public ConversationModel(String id, String creator, String name, List<User> participants, Long timeCreated, int state, int unread, String lastMessage, long lastTime) {
        this.id = id;
        this.creator = creator;
        this.name = name;
        this.timeCreated = timeCreated;
        this.state = state;
        this.unread = unread;
        this.lastTime = lastTime;
        this.participants = participants;
        this.lastMessage = lastMessage;
    }
}
