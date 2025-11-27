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
        Schema::create('perusahaan', function (Blueprint $table) {
            $table->string('idPerusahaan')->primary();
            $table->string('Nama_Perusahaan');
            $table->string('Email_Perusahaan')->unique();
            $table->string('Password_Perusahaan');
            $table->text('Alamat_Perusahaan');
            $table->string('NoTelp_Perusahaan');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('perusahaan');
    }
};
