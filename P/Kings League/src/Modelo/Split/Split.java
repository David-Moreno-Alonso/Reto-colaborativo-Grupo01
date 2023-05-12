package Modelo.Split;

import java.sql.Date;

public class Split {
    private int id;
    private Date anio;
    private TipoSplit tipoSplit;
    private EstadoSplit estadoSplit;

    private enum TipoSplit{
        Invierno,
        Verano
    }
    private enum EstadoSplit{
        Abierto,
        Cerrado
    }

    public Split() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getAnio() {
        return anio;
    }

    public void setAnio(Date anio) {
        this.anio = anio;
    }

    public TipoSplit getTipoSplit() {
        return tipoSplit;
    }

    public void setTipoSplit(TipoSplit tipoSplit) {
        this.tipoSplit = tipoSplit;
    }

    public EstadoSplit getEstadoSplit() {
        return estadoSplit;
    }

    public void setEstadoSplit(EstadoSplit estadoSplit) {
        this.estadoSplit = estadoSplit;
    }
}