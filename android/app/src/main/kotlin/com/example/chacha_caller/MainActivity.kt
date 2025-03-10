package com.chacha.caller.app
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.Keep
import com.onesignal.notifications.IActionButton;
import com.onesignal.notifications.IDisplayableMutableNotification;
import com.onesignal.notifications.INotificationReceivedEvent;
import com.onesignal.notifications.INotificationServiceExtension;

@Keep
class NotificationServiceExtension : INotificationServiceExtension {
    override fun onNotificationReceived(event: INotificationReceivedEvent) {
        val notification: IDisplayableMutableNotification = event.notification
        notification.setExtender { builder -> builder.setColor(-0xffff01) }
    }
}


class MainActivity: FlutterActivity()
