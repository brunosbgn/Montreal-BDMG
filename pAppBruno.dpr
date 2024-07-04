program pAppBruno;

uses
  Vcl.Forms,
  uviewPrincipal in 'View\uviewPrincipal.pas' {viewPrincipal},
  uviewNovo in 'View\uviewNovo.pas' {viewNovo},
  uviewAlterar in 'View\uviewAlterar.pas' {viewAlterar},
  uviewEstatisticas in 'View\uviewEstatisticas.pas' {viewEstatisticas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TviewPrincipal, viewPrincipal);
  Application.Run;
end.
