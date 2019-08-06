<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OauthClientSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
         DB::table('oauth_clients')->insert(['name'=>'Finca',
                                            'secret'=>'fb17lh9RnLl3vXzMs6Ni15tsCBJGpcHDuSokT7DG',
                                            'redirect'=>'http://localhost',
                                            'personal_access_client'=>0,
                                            'password_client'=>1,
                                            'revoked'=>0,
                                            'created_at'=>'2019-01-31 17:39:52.107',
                                            'updated_at'=>'2019-01-31 17:39:52.107',
                                       ]);
    }
}
