<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('chat', function (Blueprint $table) {
            $table->id('idChat')->primary();
            $table->string('idMitra');
            $table->string('idUser');
            $table->text('message');
            $table->enum('sender', ['mitra', 'user']); // Siapa yang kirim pesan
            $table->enum('status', ['sent', 'delivered', 'read'])->default('sent'); // Status
            $table->timestamp('sent_at')->useCurrent(); // Waktu dikirim
            $table->timestamp('read_at')->nullable(); // Waktu dibaca
            $table->timestamps();

            $table->foreign('idMitra')->references('idMitra')->on('mitra')->onDelete('cascade');
            $table->foreign('idUser')->references('idUser')->on('users')->onDelete('cascade');
        
            // Percepat pencarian chat antara mitra dan user
            $table->index(['idMitra', 'idUser']); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chat');
    }
};
