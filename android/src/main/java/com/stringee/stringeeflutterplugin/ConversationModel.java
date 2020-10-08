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
    int state;
    int unread;

    public ConversationModel(String id, String creator, String name, List<User> participants, Long timeCreated, int state, int unread, String lastMessage) {
        this.id = id;
        this.creator = creator;
        this.name = name;
        this.timeCreated = timeCreated;
        this.state = state;
        this.unread = unread;
        this.participants = participants;
        this.lastMessage = lastMessage;
    }
}
