using System;
using System.Data;
using System.Data.SqlClient;

namespace TallerMecanico.Datos
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;

        private string cadenaConexion = "Server=localhost,1433;Database=TallerMecanicoDB;User Id=sa;Password=BaseDatos#2;TrustServerCertificate=True;";

        public AccesoDatos()
        {
            conexion = new SqlConnection(cadenaConexion);
            comando = new SqlCommand();
        }

        public void SetearConsulta(string consulta)
        {
            comando.CommandType = CommandType.Text;
            comando.CommandText = consulta;
            comando.Parameters.Clear();
        }

        public void SetearProcedimiento(string sp)
        {
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = sp;
            comando.Parameters.Clear();
        }

        public void SetearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor ?? DBNull.Value);
        }

        public DataTable EjecutarConsultaTabla()
        {
            DataTable tabla = new DataTable();
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                SqlDataAdapter adaptador = new SqlDataAdapter(comando);
                adaptador.Fill(tabla);
                return tabla;
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
        }

        public void EjecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                comando.ExecuteNonQuery();
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
        }
    }
}