package com.example.petly

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainScreenActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // activity_main_screen.xml 레이아웃 설정
        setContentView(R.layout.activity_main_screen)
    }
}