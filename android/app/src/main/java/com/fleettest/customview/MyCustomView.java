package com.fleettest.customview;

import android.content.Context;
import android.graphics.Color;
import android.text.InputType;
import android.util.AttributeSet;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.RelativeLayout;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.fleettest.MainActivity;
import com.salesforce.android.chat.core.ChatConfiguration;
import com.salesforce.android.chat.core.model.ChatUserData;
import com.salesforce.android.chat.ui.ChatUI;
import com.salesforce.android.chat.ui.ChatUIClient;
import com.salesforce.android.chat.ui.ChatUIConfiguration;
import com.salesforce.android.chat.ui.model.PreChatPickListField;
import com.salesforce.android.chat.ui.model.PreChatTextInputField;
import com.salesforce.android.chat.ui.model.QueueStyle;
import com.salesforce.android.service.common.utilities.control.Async;

import static com.salesforce.android.chat.ui.model.PreChatPickListField.*;

public class MyCustomView extends RelativeLayout {

    private boolean status = false;

    public static final String ORG_ID = "00D63000000MoTt";
    public static final String DEPLOYMENT_ID = "57263000000Clar";
    public static final String BUTTON_ID = "57363000000CmJy";
    public static final String LIVE_AGENT_POD = "d.la1-c1cs-ia2.salesforceliveagent.com";

    public MyCustomView(Context context) {
        super(context);
    }

    public MyCustomView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public MyCustomView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void onFinishInflate() {
        super.onFinishInflate();

        this.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                MyCustomView.this.onClick();
            }
        });
    }

    public void setStatus(boolean status) {
        this.status = status;
        setBackgroundColor( this.status ? Color.GREEN : Color.RED);
    }

    public void onClick() {

        System.out.println("native event: on click event");

        // Some simple string fields
        PreChatTextInputField firstName = new PreChatTextInputField.Builder()
                .required(true)
                .build("Please enter your first name", "First Name");
        // First string in build() is what the user sees on the device,
        // the second string is what the agent sees in the transcript...
        PreChatTextInputField lastName = new PreChatTextInputField.Builder()
                .required(true)
                .build("Please enter your last name", "Last Name");

// An email field
        PreChatTextInputField email = new PreChatTextInputField.Builder()
                .required(true)
                .inputType(EditorInfo.TYPE_TEXT_VARIATION_EMAIL_ADDRESS)
                .mapToChatTranscriptFieldName("Email__c")
                .build("Please enter your email", "Email Address");

// A phone number field (that isn't displayed to agent)
        PreChatTextInputField phoneNumber = new PreChatTextInputField.Builder()
                .displayedToAgent(false)
                .inputType(InputType.TYPE_CLASS_PHONE)
                .build("Phone number (Agent can't see this)", "Phone");

// A read-only field
        PreChatTextInputField subject = new PreChatTextInputField.Builder()
                .readOnly(true)
                .initialValue("Read-only case subject")
                .build("Case Subject", "Subject");

// A long message field
        PreChatTextInputField description = new PreChatTextInputField.Builder()
                .inputType(EditorInfo.TYPE_TEXT_VARIATION_LONG_MESSAGE)
                .maxValueLength(200)
                .build("Please describe your problem", "Description");

// A picklist field
        PreChatPickListField priority = new Builder()
                .required(true)
                .addOption(new Option("Low Priority", "Low"))
                .addOption(new Option("Medium Priority", "Medium"))
                .addOption(new Option("High Priority", "High"))
                .addOption(new Option("AHHHHHHHH!!!", "Critical"))
                .build("Issue Priority", "Priority");

// You can also create hidden fields that the user doesn't see, but
// still gets passed along to the agent using ChatUserData...
        ChatUserData hiddenField = new ChatUserData(
                "Hidden Custom Data",
                "The user doesn't see this information",
                true);

        // chat setup
        // Create the chat configuration builder
        final ChatConfiguration.Builder chatConfigurationBuilder =
                new ChatConfiguration.Builder(ORG_ID, BUTTON_ID,
                        DEPLOYMENT_ID, LIVE_AGENT_POD);

        // Add user data and entities
        chatConfigurationBuilder
                        .chatUserData(firstName, lastName, email, priority,
                                subject, description, phoneNumber, hiddenField);

        // Build the chat configuration object
        ChatConfiguration chatConfiguration = chatConfigurationBuilder.build();

        ChatUI.configure(ChatUIConfiguration.create(chatConfiguration))
                .createClient(MainActivity.getActivity().getApplicationContext())
                .onResult(new Async.ResultHandler<ChatUIClient>() {
                    @Override public void handleResult (Async<?> operation,
                                                        ChatUIClient chatUIClient) {
                        chatUIClient.startChatSession(MainActivity.getActivity());
                    }
                });


        WritableMap event = Arguments.createMap();

        event.putString("value1","react demo");
        event.putInt("value2",1);

        ReactContext reactContext = (ReactContext)getContext();
        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onClickEvent", event);
    }

}