unit UfrmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Math, ShellAPI;

type
  TfrmMainForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    shapeEntrada2: TShape;
    shapeEntrada1: TShape;
    shapeNeuronio1: TShape;
    shapeNeuronio2: TShape;
    shapeNeuronio3: TShape;
    edtDesejada: TLabeledEdit;
    edtValorX2: TLabeledEdit;
    edtValorX1: TLabeledEdit;
    lblY: TLabel;
    lblZ1: TLabel;
    lblZ2: TLabel;
    lblW11: TLabel;
    lblW21: TLabel;
    lblW22: TLabel;
    lblW12: TLabel;
    imgW1: TImage;
    imgW2: TImage;
    imgW12: TImage;
    imgWZ1: TImage;
    imgWZ2: TImage;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    imgZ1: TImage;
    imgZ2: TImage;
    imgZ3: TImage;
    lblW23: TLabel;
    lblW13: TLabel;
    lblWZ3: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    shapeCamadaOculta: TShape;
    shapeCamadaEntrada: TShape;
    shapeCamadaSaida: TShape;
    lblWZ1: TLabel;
    lblWZ2: TLabel;
    Label23: TLabel;
    gbxPropriedades: TGroupBox;
    edtAlpha: TLabeledEdit;
    edtLambda: TLabeledEdit;
    edtErro: TLabeledEdit;
    gbxW: TGroupBox;
    edtW11: TLabeledEdit;
    edtW12: TLabeledEdit;
    edtW13: TLabeledEdit;
    edtW21: TLabeledEdit;
    edtW22: TLabeledEdit;
    edtW23: TLabeledEdit;
    gbxWZ: TGroupBox;
    edtWZ1: TLabeledEdit;
    edtWZ2: TLabeledEdit;
    edtWZ3: TLabeledEdit;
    edtIteracoes: TLabeledEdit;
    mmLog: TMemo;
    btnCalcular: TBitBtn;
    pnlHeader: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblErroSaidaNeuronio: TLabel;
    lblVariacaoPeso: TLabel;
    lblErroNeuronio: TLabel;
    edtDelay: TLabeledEdit;
    imgExemplo1: TImage;
    imgExemplo1s: TImage;
    imgExemplo2: TImage;
    imgExemplo2s: TImage;
    imgExemplo3: TImage;
    imgExemplo3s: TImage;
    imgExemplo4: TImage;
    imgExemplo4s: TImage;
    imgSetaParaFrente: TImage;
    imgSetaParaTras: TImage;
    imgCirculo: TImage;
    Label10: TLabel;
    lblErroZ3: TLabel;
    lblDeltaZ3: TLabel;
    lblSigmaZ3: TLabel;
    lblErroZ1: TLabel;
    lblDeltaZ1: TLabel;
    lblSigmaZ1: TLabel;
    lblErroZ2: TLabel;
    lblDeltaZ2: TLabel;
    lblSigmaZ2: TLabel;
    lblThetaZ1: TLabel;
    lblThetaZ2: TLabel;
    lblThetaZ3: TLabel;
    lblZ3: TLabel;
    btnSobre: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure edtDelayChange(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
  private
    const
      E : Double = 2.718281828459045235360287471352662497757;
    var
      x : array [0..2] of Double;
      w : array [0..2] of array[0..1] of Double;
      wz : array [0..2] of Double;
      baia : array [0..2] of Double;
      alpha : Double;
      z : array [0..2] of Double;
      y : Double;
      erro : Double;
      desejada : Double;
      teta : array [0..2] of Double;
      erroSaidaNeuronio : array [0..2] of Double;
      erroNeuronio : array [0..2] of Double;
      variacaoPeso : array [0..2] of Double;
      novoW : array [0..2] of array[0..1] of Double;
      novoBaia : array [0..2] of Double;
      lambda : Double;

      procedure inicializar();
      procedure atualizarValores();
      procedure validarValores(Sender: TObject);
      procedure calcularBackPropagation();
      procedure validacoes();
      procedure log(const aTexto : string = '-----------');
      procedure delay();
  public
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.dfm}

procedure TfrmMainForm.atualizarValores;
begin
  lblW11.Caption := 'W11: '+ FloatToStrF(w[0][0], ffGeneral, 4, 4);
  lblW12.Caption := 'W12: '+ FloatToStrF(w[0][1], ffGeneral, 4, 4);
  lblW13.Caption := 'W13: '+ FloatToStrF(w[2][0], ffGeneral, 4, 4);

  lblW21.Caption := 'W21: '+ FloatToStrF(w[1][0], ffGeneral, 4, 4);
  lblW22.Caption := 'W22: '+ FloatToStrF(w[1][1], ffGeneral, 4, 4);
  lblW23.Caption := 'W23: '+ FloatToStrF(w[2][1], ffGeneral, 4, 4);

  lblZ1.Caption := 'Z1: '+FloatToStrF(z[0], ffGeneral, 4, 4);
  lblZ2.Caption := 'Z2: '+FloatToStrF(z[1], ffGeneral, 4, 4);
  lblZ3.Caption := 'Z3: '+FloatToStrF(y, ffGeneral, 4, 4);

  lblWZ1.Caption := 'WZ1: '+ FloatToStrF(wz[0], ffGeneral, 4, 4);
  lblWZ2.Caption := 'WZ2: '+ FloatToStrF(wz[1], ffGeneral, 4, 4);
  lblWZ3.Caption := 'WZ3: '+ FloatToStrF(wz[2], ffGeneral, 4, 4);

  lblErroSaidaNeuronio.Caption := 'Delta: {'+FloatToStrF(erroSaidaNeuronio[0], ffGeneral, 4, 4)+
  ' | '+FloatToStrF(erroSaidaNeuronio[1], ffGeneral, 4, 4)+' | '+FloatToStrF(erroSaidaNeuronio[2], ffGeneral, 4, 4)+'}';

  lblVariacaoPeso.Caption := 'Sigma: {'+FloatToStrF(variacaoPeso[0], ffGeneral, 4, 4)+
  ' | '+FloatToStrF(variacaoPeso[1], ffGeneral, 4, 4)+' | '+FloatToStrF(variacaoPeso[2], ffGeneral, 4, 4)+'}';

  lblErroNeuronio.Caption := 'Erro neurônio: {'+FloatToStrF(erroNeuronio[0], ffGeneral, 4, 4)+
  ' | '+FloatToStrF(erroNeuronio[1], ffGeneral, 4, 4)+' | '+FloatToStrF(erro, ffGeneral, 4, 4)+'}';

  lblErroZ3.Caption := 'Erro: '+FloatToStrF(erro, ffGeneral, 4, 4);
  lblErroZ2.Caption := 'Erro: '+FloatToStrF(erroSaidaNeuronio[1], ffGeneral, 4, 4);
  lblErroZ1.Caption := 'Erro: '+FloatToStrF(erroSaidaNeuronio[0], ffGeneral, 4, 4);

  lblDeltaZ1.Caption := 'Delta: '+FloatToStrF(erroNeuronio[0], ffGeneral, 4, 4);
  lblDeltaZ2.Caption := 'Delta: '+FloatToStrF(erroNeuronio[1], ffGeneral, 4, 4);
  lblDeltaZ3.Caption := 'Delta: '+FloatToStrF(erroSaidaNeuronio[2], ffGeneral, 4, 4);

  lblSigmaZ1.Caption := 'Sigma: '+FloatToStrF(variacaoPeso[0], ffGeneral, 4, 4);
  lblSigmaZ2.Caption := 'Sigma: '+FloatToStrF(variacaoPeso[1], ffGeneral, 4, 4);
  lblSigmaZ3.Caption := 'Sigma: '+FloatToStrF(variacaoPeso[2], ffGeneral, 4, 4);

  lblThetaZ1.Caption := 'Theta: '+FloatToStrF(teta[0], ffGeneral, 4, 4);
  lblThetaZ2.Caption := 'Theta: '+FloatToStrF(teta[1], ffGeneral, 4, 4);
  lblThetaZ3.Caption := 'Theta: '+FloatToStrF(teta[2], ffGeneral, 4, 4);

  lblY.Caption := FloatToStrF(y, ffGeneral, 4, 4);
end;

procedure TfrmMainForm.btnCalcularClick(Sender: TObject);
begin
  validacoes();
  inicializar();
  atualizarValores();
  calcularBackPropagation();
end;

procedure TfrmMainForm.btnSobreClick(Sender: TObject);
begin
  Application.MessageBox(
  'Exibição de BackPropagation em Delphi! '+#13#10+
  'Versão: 1.0'+#13#10#13#10+
  'Software desenvolvido por:'+#13#10#13#10+
  'Aluno: Lucas da Silva'+#13#10+
  'R.A.: 203417'+#13#10+
  'Curso: Engenharia da Computação, 9º termo - Noturno'+#13#10#13#10+
  'Professor: James Clauton da Silva'+#13#10#13#10+
  'Data: 11 de abril de 2018'+#13#10#13#10+
  'Unisalesiano Araçatuba-SP'+#13#10#13#10+
  'Contato: lucas21021996@gmail.com'+#13#10+
  'Acesse meu GitHub: https://github.com/LucasMence ',
  'Sobre este Software',
  MB_ICONINFORMATION+
  MB_OK+
  MB_DEFBUTTON1);

  ShellExecute(0, 'open', PChar('https://github.com/LucasMence'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMainForm.calcularBackPropagation;
var
  index,
  subIndex,
  iteracoes : Integer;
  logErro : TStringList;
  margemErro : Double;
begin
  try
    Application.ProcessMessages();
    log('Iniciando:');

    iteracoes := StrToInt(edtIteracoes.Text);
    margemErro := StrToFloat(edtErro.Text);
    if margemErro <= 0 then
      margemErro := 0.01;
    margemErro := (desejada * margemErro) / 100;

    imgW1.Picture := imgExemplo1.Picture;
    imgW2.Picture := imgExemplo1.Picture;
    imgW12.Picture := imgExemplo4.Picture;
    imgZ1.Picture := imgExemplo1.Picture;
    imgZ2.Picture := imgExemplo1.Picture;
    imgWZ1.Picture := imgExemplo2.Picture;
    imgWZ2.Picture := imgExemplo3.Picture;
    imgZ3.Picture := imgExemplo1.Picture;
    Application.ProcessMessages();

    for index := 1 to iteracoes do
    begin
      pnlHeader.Caption := 'BackPropagation - Real-time - Para uso didático ( Iteração '
      +IntToStr(index)+' )';

      atualizarValores();
      log();
      log('Iteração: '+IntToStr(index));
      log();
      Application.ProcessMessages();
      imgSetaParaFrente.Visible := True;
      delay();

      log('Calculando valor do neurônio Z1 e Z2:');
      log('Z[] = somatória( x[] * w[] )');
      imgW1.Picture := imgExemplo1s.Picture;
      imgW2.Picture := imgExemplo1s.Picture;
      imgW12.Picture := imgExemplo4s.Picture;
      imgZ1.Picture := imgExemplo1s.Picture;
      imgZ2.Picture := imgExemplo1s.Picture;

      lblZ1.Font.Color := clRed;
      lblZ2.Font.Color := clRed;

      for subIndex := 0 to 1 do
      begin
        z[subIndex] := (x[0] * w[0][subIndex]) + (x[1] * w[1][subIndex]) + (baia[subIndex] * w[2][subIndex]);
        z[subIndex] := (1 - Power(E, (-lambda * z[subIndex]))) / (1 + Power(E, (-lambda * z[subIndex])));
      end;

      atualizarValores();
      Application.ProcessMessages();
      delay();
    
      imgW1.Picture := imgExemplo1.Picture;
      imgW2.Picture := imgExemplo1.Picture;
      imgW12.Picture := imgExemplo4.Picture;
      imgZ1.Picture := imgExemplo1.Picture;
      imgZ2.Picture := imgExemplo1.Picture;
      log('Calculando Z3:');
      log('Z3 = somatória( wz[] * z[] )');
      imgWZ1.Picture := imgExemplo2s.Picture;
      imgWZ2.Picture := imgExemplo3s.Picture;
      imgZ3.Picture := imgExemplo1s.Picture;
    

      lblZ1.Font.Color := clBlack;
      lblZ2.Font.Color := clBlack;
      lblZ3.Font.Color := clRed;

      //calculando peso do neuronio de saida
      y := (wz[0] * z[0]) + (wz[1] * z[1]) + (wz[2] * baia[2]);
      y := (1 - Power(E, (-lambda * y))) / (1 + Power(E, (-lambda * y)));

      atualizarValores();
      Application.ProcessMessages();
      delay();

      log('Obtendo valor de saida ( Y ): ');
      log('Y = Z3');
      imgSetaParaFrente.Visible := False;
      imgCirculo.Visible := True;
      imgWZ1.Picture := imgExemplo2.Picture;
      imgWZ2.Picture := imgExemplo3.Picture;
      imgZ3.Picture := imgExemplo1.Picture;
      lblZ3.Font.Color := clBlack;

      atualizarValores();
      Application.ProcessMessages();
      delay();

      if (y + margemErro) < desejada then
      begin
        imgSetaParaTras.Visible := True;

        log('Calculando erro ( E ) da saida desejada: ');
        log('E = d - y');
        imgCirculo.Visible := False;

        erro := desejada - y;
        lblErroZ3.Font.Color := clRed;
        lblErroZ3.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        lblErroZ3.Font.Color := clBlack;
        lblErroZ3.Font.Style := [];
    
        imgZ3.Picture := imgExemplo1s.Picture;

        log('Calculando valor de theta de Z3:');
        log('Theta(Z3) = 0.5 * lambda * (1 - y²) ');

        teta[2] := 0.5 * lambda * (1 - (y * y));

        lblThetaZ3.Font.Color := clRed;
        lblThetaZ3.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando delta de Z3:');
        log('Delta(Z3) = theta(Z3) * E ');
        erroSaidaNeuronio[2] := teta[2] * erro;

        lblThetaZ3.Font.Color := clBlack;
        lblThetaZ3.Font.Style := [];
        lblDeltaZ3.Font.Color := clRed;
        lblDeltaZ3.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando sigma de Z3');
        log('Sigma(Z3) = 2 * alpha * E * theta(Z3)');
        variacaoPeso[2] := 2 * alpha * erro * teta[2];

        lblDeltaZ3.Font.Color := clBlack;
        lblDeltaZ3.Font.Style := [];
        lblSigmaZ3.Font.Color := clRed;
        lblSigmaZ3.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        lblSigmaZ3.Font.Color := clBlack;
        lblSigmaZ3.Font.Style := [];

        log('Gerando novos pesos dos valores de WZ:');
        log('WZ[] = wz[] + ( sigma(Z3) * z[] ) ');
        imgZ3.Picture := imgExemplo1.Picture;
        imgWZ1.Picture := imgExemplo2s.Picture;
        imgWZ2.Picture := imgExemplo3s.Picture;

        //calculando novo peso das arestas e da baia
        novoW[2][0] := variacaoPeso[2] * z[0];
        novoW[2][1] := variacaoPeso[2] * z[1];
        novoBaia[2] := variacaoPeso[2] * baia[1];

        novoW[2][0] := wz[0] + novoW[2][0];
        novoW[2][1] := wz[1] + novoW[2][1];
        novoBaia[2] := wz[2] + novoBaia[2];

        wz[0] := novoW[2][0];
        wz[1] := novoW[2][1];
        wz[2] := novoBaia[2];

        lblWZ1.Font.Color := clRed;
        lblWZ1.Font.Style := [fsBold];
        lblWZ2.Font.Color := clRed;
        lblWZ2.Font.Style := [fsBold];
        lblWZ3.Font.Color := clRed;
        lblWZ3.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando erro de saida dos neuronios Z1 e Z2:');
        log('E[] = wz[] * delta(Z3) ');
        imgWZ1.Picture := imgExemplo2.Picture;
        imgWZ2.Picture := imgExemplo3.Picture;
        imgZ1.Picture := imgExemplo1s.Picture;
        imgZ2.Picture := imgExemplo1s.Picture;

        //calculando erro de saida dos demais neuronios z1 e z2
        erroSaidaNeuronio[0] := wz[0] * erroSaidaNeuronio[2];
        erroSaidaNeuronio[1] := wz[1] * erroSaidaNeuronio[2];

        lblErroZ1.Font.Color := clRed;
        lblErroZ1.Font.Style := [fsBold];
        lblErroZ2.Font.Color := clRed;
        lblErroZ2.Font.Style := [fsBold];
        lblWZ1.Font.Color := clBlack;
        lblWZ1.Font.Style := [];
        lblWZ2.Font.Color := clBlack;
        lblWZ2.Font.Style := [];
        lblWZ3.Font.Color := clBlack;
        lblWZ3.Font.Style := [];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando theta Z1 e Z2:');
        log('Theta[] = 0.5 * lambda * (1 - z[]²) ');
        //calculando teta z1 e z2
        teta[0] := 0.5 * lambda * (1 - (z[0] * z[0]));
        teta[1] := 0.5 * lambda * (1 - (z[1] * z[1]));

        lblThetaZ1.Font.Color := clRed;
        lblThetaZ1.Font.Style := [fsBold];
        lblThetaZ2.Font.Color := clRed;
        lblThetaZ2.Font.Style := [fsBold];

        lblErroZ1.Font.Color := clBlack;
        lblErroZ1.Font.Style := [];
        lblErroZ2.Font.Color := clBlack;
        lblErroZ2.Font.Style := [];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando delta de Z1 e Z2:');
        log('Delta[] = wz[] * delta[Z3] * theta[] ');
        //calculando erro Neuronio
        erroNeuronio[0] := wz[0] * erroSaidaNeuronio[2] * teta[0];
        erroNeuronio[1] := wz[1] * erroSaidaNeuronio[2] * teta[1];

        lblDeltaZ1.Font.Color := clRed;
        lblDeltaZ1.Font.Style := [fsBold];
        lblDeltaZ2.Font.Color := clRed;
        lblDeltaZ2.Font.Style := [fsBold];
        lblThetaZ1.Font.Color := clBlack;
        lblThetaZ1.Font.Style := [];
        lblThetaZ2.Font.Color := clBlack;
        lblThetaZ2.Font.Style := [];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando sigma de Z1 e Z2:');
        log('Sigma[] = 2 * alpha * e[] * theta[] ');
        //calculando variacao de peso dos demais neuronios
        variacaoPeso[0] := 2 * alpha * erroSaidaNeuronio[0] * teta[0];
        variacaoPeso[1] := 2 * alpha * erroSaidaNeuronio[1] * teta[1];

        lblDeltaZ1.Font.Color := clBlack;
        lblDeltaZ1.Font.Style := [];
        lblDeltaZ2.Font.Color := clBlack;
        lblDeltaZ2.Font.Style := [];

        lblSigmaZ1.Font.Color := clRed;
        lblSigmaZ1.Font.Style := [fsBold];
        lblSigmaZ2.Font.Color := clRed;
        lblSigmaZ2.Font.Style := [fsBold];

        atualizarValores();
        Application.ProcessMessages();
        delay();

        log('Calculando novos pesos de W:');
        log('W[] = sigma[] + w[] * x[] ');
        imgZ1.Picture := imgExemplo1.Picture;
        imgZ2.Picture := imgExemplo1.Picture;
        imgW1.Picture := imgExemplo1s.Picture;
        imgW2.Picture := imgExemplo1s.Picture;
        imgW12.Picture := imgExemplo4s.Picture;

        //calculando novos pesos para as demais arestas
        novoW[0][0] := variacaoPeso[0] + w[0][0] * x[0];
        novoW[1][0] := variacaoPeso[0] + w[1][0] * x[1];
        novoBaia[0] := variacaoPeso[0] + w[2][0] * x[2];

        novoW[0][1] := variacaoPeso[1] + w[0][1] * x[0];
        novoW[1][1] := variacaoPeso[1] + w[1][1] * x[1];
        novoBaia[1] := variacaoPeso[1] + w[2][1] * x[2];

        w[0][0] := novoW[0][0];
        w[1][0] := novoW[1][0];
        w[2][0] := novoW[2][0];
        baia[0] := novoBaia[0];

        w[0][1] := novoW[0][1];
        w[1][1] := novoW[1][1];
        w[2][1] := novoW[2][1];
        baia[1] := novoBaia[1];

        lblSigmaZ1.Font.Color := clBlack;
        lblSigmaZ1.Font.Style := [];
        lblSigmaZ2.Font.Color := clBlack;
        lblSigmaZ2.Font.Style := [];
        lblW11.Font.Color := clRed;
        lblW11.Font.Style := [fsBold];
        lblW12.Font.Color := clRed;
        lblW12.Font.Style := [fsBold];
        lblW13.Font.Color := clRed;
        lblW13.Font.Style := [fsBold];
        lblW21.Font.Color := clRed;
        lblW21.Font.Style := [fsBold];
        lblW22.Font.Color := clRed;
        lblW22.Font.Style := [fsBold];
        lblW23.Font.Color := clRed;
        lblW23.Font.Style := [fsBold];


        atualizarValores();
        Application.ProcessMessages();
        delay();
        imgW1.Picture := imgExemplo1.Picture;
        imgW2.Picture := imgExemplo1.Picture;
        imgW12.Picture := imgExemplo4.Picture;
        imgSetaParaTras.Visible := False;

        lblW11.Font.Color := clBlack;
        lblW11.Font.Style := [];
        lblW12.Font.Color := clBlack;
        lblW12.Font.Style := [];
        lblW13.Font.Color := clBlack;
        lblW13.Font.Style := [];
        lblW21.Font.Color := clBlack;
        lblW21.Font.Style := [];
        lblW22.Font.Color := clBlack;
        lblW22.Font.Style := [];
        lblW23.Font.Color := clBlack;
        lblW23.Font.Style := [];

        log();
        log('Iteracao finalizada!');

        atualizarValores();
        Application.ProcessMessages();
        delay();
      end
      else
      begin
        log();
        log('Nesta iteracao já é possivel obter o resultado desejado '+
        'utilizando os pesos informados! ');
        if margemErro >= 1 then
          log('Para este caso o resultado de Y chegou no valor com a margem do erro aceitavel '+
          'de '+edtErro.Text+'%!');
        log('Continuar a execução de mais iterações não irá fazer o neurônio aprender '+
        'mais, pois o valor não irá mais ser alterado!');
        log('Treinamento concluido na iteração '+IntToStr(index)+'º !');
        log();
        break;
      end;

    end;
    log();
    log('Processo de iterações concluido!');
    if (y + margemErro) < desejada then
      log('Com este número de iterações não foi possivel chegar no valor desejado! '+
      'Ainda é possivel treinar mais, aumente o número de iterações para chegar no valor '+
      'desejado!');
    log();
  except
    on e:exception do
    begin
      lblW11.Font.Color := clBlack;
      lblW11.Font.Style := [];
      lblW12.Font.Color := clBlack;
      lblW12.Font.Style := [];
      lblW13.Font.Color := clBlack;
      lblW13.Font.Style := [];
      lblW21.Font.Color := clBlack;
      lblW21.Font.Style := [];
      lblW22.Font.Color := clBlack;
      lblW22.Font.Style := [];
      lblW23.Font.Color := clBlack;
      lblW23.Font.Style := [];
      lblSigmaZ1.Font.Color := clBlack;
      lblSigmaZ1.Font.Style := [];
      lblSigmaZ2.Font.Color := clBlack;
      lblSigmaZ2.Font.Style := [];

      log();
      log('Ocorreu um erro de estouro no limite das iteracoes!');
      log('Isso ocorreu devido a um problema de tamanho das casas exponenciais!');
      log('Basicamente este tipo de sistema não comporta operações deste nivel...');
      log('Um log com a mensagem de erro foi salvo na pasta raiz deste programa com '+
      'o nome de "log_erro.txt"');
      log('A ultima iteracao restante foi a '+IntToStr(index)+'º !');
      log();

      logErro := TStringList.Create();
      logErro.Add('-----------------'#13#10+
      'Ocorreu um erro ao fazer o processamento da rede neural, segue abaixo '+
      'mais detalhes sobre o problema:'+#13#10#13#10+e.Message);
      logErro.SaveToFile(ExtractFilePath(Application.ExeName)+'log_erro.txt');
      logErro.Free();

    end;
  end;
end;

procedure TfrmMainForm.delay;
begin
  Sleep(StrToInt(edtDelay.Text));
end;

procedure TfrmMainForm.edtChange(Sender: TObject);
begin
  validarValores(Sender);
end;

procedure TfrmMainForm.edtDelayChange(Sender: TObject);
begin
  validarValores(Sender);
  if (edtDelay.Text = EmptyStr) then
    edtDelay.Text := '0';
end;

procedure TfrmMainForm.FormShow(Sender: TObject);
begin
  shapeCamadaEntrada.BringToFront();
  shapeCamadaOculta.BringToFront();
  shapeCamadaSaida.BringToFront();
  atualizarValores();
end;

procedure TfrmMainForm.inicializar;
var
  index : Integer;
begin
  mmLog.Text := EmptyStr;
  x[0] := StrToFloat(edtValorX1.Text);
  x[1] := StrToFloat(edtValorX2.Text);
  x[2] := 1;

  w[0][0] := StrToFloat(edtW11.Text);//-1;
  w[0][1] := StrToFloat(edtW12.Text); //1.5;
  w[1][0] := StrToFloat(edtW21.Text);//2;
  w[1][1] := StrToFloat(edtW22.Text);//1;
  w[2][0] := StrToFloat(edtW13.Text);//1;
  w[2][1] := StrToFloat(edtW23.Text);//-1;

  wz[0] := StrToFloat(edtWZ1.Text);//-2;
  wz[1] := StrToFloat(edtWZ2.Text);//-1;
  wz[2] := StrToFloat(edtWZ3.Text);//1;

  baia[0] := 1;
  baia[1] := 1;
  baia[2] := 1;

  alpha := StrToFloat(edtAlpha.Text);//0.8;
  y:= 0;
  erro := 0;
  desejada := StrToFloat(edtDesejada.Text);//0.5;
  lambda := StrToFloat(edtLambda.Text);//0.5;

  for index := 0 to 2 do
  begin
    z[index] := 0;
    teta[index] := 0;
    erroSaidaNeuronio[index] := 0;
    erroNeuronio[index] := 0;
    variacaoPeso[index] := 0;
    novoBaia[index] := 0;
  end;

  novoW[0][0] := 0;
  novoW[0][1] := 0;
  novoW[1][0] := 0;
  novoW[1][1] := 0;
  novoW[2][0] := 0;
  novoW[2][1] := 0;
end;

procedure TfrmMainForm.log(const aTexto: string);
begin
  mmLog.Lines.Add(aTexto);
end;

procedure TfrmMainForm.validacoes;
begin
  if StrToInt(edtIteracoes.Text) < 1 then
  begin
    Application.MessageBox('O número de iterações deve ser no minimo 1 (um)! ',
    'Iterações inválidas!',MB_ICONWARNING+MB_OK+MB_DEFBUTTON1);
    Abort;
  end;
  if True then

end;

procedure TfrmMainForm.validarValores(Sender: TObject);
var
  valor : Currency;
  resultado : Boolean;
begin
  if TLabeledEdit(Sender).Text = EmptyStr then
    Abort;
  resultado := True;
  try
    valor := StrToFloat(TLabeledEdit(Sender).Text);
  except
    resultado := False;
  end;
  if (not resultado) then
    TLabeledEdit(Sender).Text := EmptyStr;
end;

end.
