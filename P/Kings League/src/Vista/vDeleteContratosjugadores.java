package Vista;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.net.URL;

public class vDeleteContratosjugadores {
    private JPanel pPrincipal;
    private JPanel pDegradado;
    private JPanel pDatos;
    private JPanel pIniciarSesion;
    private JTextField tfID;
    private JLabel jlNombre;
    private JPanel pFooter;
    private JPanel pBotones;
    private JButton bAceptar;
    private JButton bCancelar;


    public vDeleteContratosjugadores() {
        // Poner fondo degradado
        pPrincipal = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);

                Graphics2D g2d = (Graphics2D) g;

                Color colorInicio = new Color(239, 122, 14);
                Color colorFin = new Color(253, 214, 44);

                GradientPaint gradient = new GradientPaint(
                        0, 0, colorInicio,
                        0, getHeight(), colorFin);

                g2d.setPaint(gradient);

                g2d.fillRect(0, 0, getWidth(), getHeight());
            }
        };


        pPrincipal.add(pDegradado, BorderLayout.CENTER);


    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("vDeleteContratosjugadores");
        frame.setContentPane(new vDeleteContratosjugadores().pPrincipal);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}