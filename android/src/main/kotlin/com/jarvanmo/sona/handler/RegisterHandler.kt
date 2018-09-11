package com.jarvanmo.sona.handler

import android.app.Service
import com.igexin.sdk.PushManager
import com.jarvanmo.sona.constants.ANDROID
import com.jarvanmo.sona.constants.PLATFORM
import com.jarvanmo.sona.constants.RESULT
import com.jarvanmo.sona.service.SonaPushService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

internal class RegisterHandler(private val registrar: Registrar) {


    fun register(call: MethodCall, result: MethodChannel.Result) {
        val needRegister: Boolean = call.argument("registerOnAndroid")
        if (!needRegister) {
            result.success({
                PLATFORM to ANDROID
                RESULT to true
            })
            return
        }

        val serviceName: String? = call.argument("pushServiceName")
        var serviceClass: Class<out Service> = SonaPushService::class.java
        if (serviceName.isNullOrBlank()) {
            PushManager.getInstance().initialize(registrar.context().applicationContext, serviceClass)
            result.success({
                PLATFORM to ANDROID
                RESULT to true
            })
            return
        }

        try {
            serviceClass = Class.forName(serviceName) as Class<out Service>
            PushManager.getInstance().initialize(registrar.context().applicationContext, serviceClass)
            result.success({
                PLATFORM to ANDROID
                RESULT to true
            })
        } catch (e: ClassNotFoundException) {
            result.error("ClassNotFoundException","Can't find class $serviceName.stacktrace from android:\n ${e.message}",serviceName)
        } catch (e: ClassCastException) {
            result.error("ClassCastException","The class name given is not a sub type of android.app.Service. Here's stacktrace from android:\n${e.message}",serviceName)
        }


    }
}