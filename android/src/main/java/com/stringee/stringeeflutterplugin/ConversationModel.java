package com.stringee.stringeeflutterplugin;

import com.google.gson.annotations.SerializedName;
import com.stringee.messaging.User;

import java.util.List;

public class ConversationModel {
    @SerializedName("id")
    String id;
    @SerializedName("creator")
    String creator;
    @SerializedName("name")
    String name;
    @SerializedName("participants")
    List<User> participants;
    @SerializedName("timeCreated")
    Long timeCreated;
    @SerializedName("lastMessage")
    String lastMessage;
    @SerializedName("lastTime")
    long lastTime;
    @SerializedName("state")
    int state;
    @SerializedName("unread")
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
