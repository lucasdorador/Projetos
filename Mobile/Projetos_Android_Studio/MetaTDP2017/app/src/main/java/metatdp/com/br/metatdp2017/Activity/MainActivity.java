package metatdp.com.br.metatdp2017.Activity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.widget.FrameLayout;

import java.io.Serializable;

import metatdp.com.br.metatdp2017.ConexaoWebService.ComunicaWebService_old;
import metatdp.com.br.metatdp2017.Constants.Url_Conexao;
import metatdp.com.br.metatdp2017.R;
import metatdp.com.br.metatdp2017.fragments.FragmentConfiguracao;
import metatdp.com.br.metatdp2017.fragments.FragmentConsulta;
import metatdp.com.br.metatdp2017.fragments.FragmentPrincipal;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    private static final String STATE_SELECTED_POSITION = "selected_navigation_drawer_position";

    private ViewPager viewPager;
    private boolean mFromSavedInstanceState;
    private int mCurrentSelectedPosition;
    private FrameLayout mContentFrame;
    private Toolbar toolbar;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        viewPager = (ViewPager) findViewById(R.id.viewPager);

        toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("Meta TDP 2017");
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        SharedPreferences preferences = getSharedPreferences("configIP", Context.MODE_PRIVATE);
        Url_Conexao.IP_Pref = preferences.getString("IP", null);
        Url_Conexao.Porta_Pref = preferences.getString("PORTA", null);

        if (Url_Conexao.IP_Pref != null && Url_Conexao.Porta_Pref != null) {
            ComunicaWebService_old.pcdConfigIP(Url_Conexao.IP_Pref, Url_Conexao.Porta_Pref);
        }

        if (savedInstanceState != null) {
            mCurrentSelectedPosition = savedInstanceState.getInt(STATE_SELECTED_POSITION);
            mFromSavedInstanceState = true;
        }

        mContentFrame = (FrameLayout) findViewById(R.id.nav_contentframe);

        replaceFragment(new FragmentPrincipal(), toolbar.getTitle().toString());
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

//    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        // Inflate the menu; this adds items to the action bar if it is present.
//        getMenuInflater().inflate(R.menu.main, menu);
//        return true;
//    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        } else if (id == R.id.Home) {
            replaceFragment(new FragmentPrincipal(), "Meta TDP 2017");
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        item.setCheckable(true);
        item.setChecked(true);
        int id = item.getItemId();

        if (id == R.id.Config) {
            replaceFragment(new FragmentConfiguracao(), "Configuração de Conexão");
        } else if (id == R.id.cons_pedido) {
            replaceFragment(new FragmentConsulta(), "Consulta de Pedidos");
        } else if (id == R.id.sair) {
            finish();
        } else if (id == R.id.Home) {
            replaceFragment(new FragmentPrincipal(), "Meta TDP 2017");
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    private void replaceFragment(Fragment frag, String titulo) {
        toolbar.setTitle(titulo);
        getSupportFragmentManager().beginTransaction().replace(R.id.nav_contentframe, frag, "TAG").commit();
        mCurrentSelectedPosition = 0;
    }
}
