//
// ----- structure definitions
//
typedef struct trapForm
	{
	int	y1;
	int	y2;
	int	y3;
	int	y4;
	int	width;
	} trapForm;


typedef	struct DDAVars
	{
	int	DDAinitval;
	int	DDAmoves;
	int	DDAdelsx;
	int	DDAdelsy;
	int	DDAdeldx;
	int	DDAdeldy;
	int	DDAdelse;
	int	DDAdelde;
	} DDAVars;



//
// -----	Function Prototypes in sya.asm
//
void	interpolate(int srcSize, int dstSize);
void	NextDDA(int *x, int *y, DDAVars far *DDAVarsPtr);
void	InitDDA(int x1, int y1, int x2, int y2, DDAVars far *DDAVarsPtr);
void	vidMode(int inOrOut, char far *palPtr);
void	displayWall(int x, int y, int destWidth, int destHeight, 
						int far *srcptr, char far *bufPtr);
void	InitInterLoop(int srcSize, int destSize, DDAVars far *DDAVarsPtr);
void	InterLoop(int *srcOffset, int *destOffset, DDAVars far *DDAVarsPtr);
