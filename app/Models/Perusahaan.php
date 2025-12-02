<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Perusahaan extends Model
{
    use HasFactory;

    protected $table = 'perusahaan';
    protected $primaryKey = 'idPerusahaan';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'idPerusahaan',
        'Nama_Perusahaan',
        'Email_Perusahaan',
        'Password_Perusahaan',
        'Alamat_Perusahaan',
        'NoTelp_Perusahaan',
        'created_at',
        'updated_at',
    ];

    // Relationships
    public function mitra()
    {
        return $this->hasMany(Mitra::class, 'idPerusahaan', 'idPerusahaan');
    }
}
