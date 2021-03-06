Samplers = {
	MapTexture = {
		Index = 0;
		MinFilter = "Point";
		MagFilter = "Point";
		MipFilter = "None";
		AddressU = "Wrap";
		AddressV = "Wrap";
	}
}

AddSamplers()

BlendState = {
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "src_alpha";
	DestBlend = "inv_src_alpha";
}

Includes = {
}

Defines = { }

DeclareShared( [[

CONSTANT_BUFFER( 0, 0 )
{
float4x4 WorldViewProjectionMatrix	;
float4 Color 						;
float vXOffset						;	// For textures with more than one frame
}
]] )

DeclareVertex( [[
struct VS_INPUT
{
	float3 vPosition  : POSITION;
	float2 vTexCoord  : TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
	float4  vPosition : POSITION;
	float2  vTexCoord : TEXCOORD0;
};

]] )

Up = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderUp";
	ShaderModel = 3;
}

Down = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderUp";
	ShaderModel = 3;
}

Disable = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderUp";
	ShaderModel = 3;
}

Over = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderUp";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[

VS_OUTPUT main(const VS_INPUT v )
{
    VS_OUTPUT Out;
    Out.vPosition  = mul( float4( v.vPosition.xyz, 1 ), WorldViewProjectionMatrix );

    Out.vTexCoord  = v.vTexCoord;
	Out.vTexCoord.x += vXOffset;
    return Out;
}

]] )

DeclareShader( "PixelShaderUp", [[
	
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( MapTexture, v.vTexCoord );
	OutColor *= Color;
 
    return OutColor;
}

	
]] )
