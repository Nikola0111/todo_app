package com.example.todo_app

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import io.flutter.embedding.android.SplashScreen

class SimpleSplashScreen : SplashScreen {
    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? {

        return LayoutInflater.from(context).inflate(R.layout.splash_layout, null, false)
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }

}