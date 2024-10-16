package com.example.petly_main;

import android.os.Bundle;
import android.widget.Button;
import android.widget.CalendarView;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private CalendarView calendarView;
    private TextView tipsTextView;
    private TextView upcomingScheduleTextView;
    private Button homeButton, secondButton, thirdButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 캘린더 뷰
        calendarView = findViewById(R.id.calendarView);
        calendarView.setOnDateChangeListener((view, year, month, dayOfMonth) -> {
            // 날짜가 선택되면 처리할 코드
            String date = year + "/" + (month + 1) + "/" + dayOfMonth;
            Toast.makeText(MainActivity.this, "선택한 날짜: " + date, Toast.LENGTH_SHORT).show();
        });

        // 팁 텍스트
        tipsTextView = findViewById(R.id.tipsTextView);
        tipsTextView.setText("오늘의 반려동물 팁: 충분한 물을 제공하세요!");

        // 임박한 일정
        upcomingScheduleTextView = findViewById(R.id.upcomingScheduleTextView);
        upcomingScheduleTextView.setText("가장 임박한 일정: 예방접종 10월 20일");

        // 하단 네비게이션 바 버튼
        homeButton = findViewById(R.id.homeButton);
        secondButton = findViewById(R.id.secondButton);
        thirdButton = findViewById(R.id.thirdButton);

        homeButton.setOnClickListener(v -> {
            // 메인 화면으로 이동 (현재 화면이므로 동작 없음)
            Toast.makeText(MainActivity.this, "이미 메인 화면입니다.", Toast.LENGTH_SHORT).show();
        });

        secondButton.setOnClickListener(v -> {
            // 기능 2로 이동하는 코드 작성
            Toast.makeText(MainActivity.this, "기능 2 선택", Toast.LENGTH_SHORT).show();
        });

        thirdButton.setOnClickListener(v -> {
            // 기능 3으로 이동하는 코드 작성
            Toast.makeText(MainActivity.this, "기능 3 선택", Toast.LENGTH_SHORT).show();
        });
    }
}
