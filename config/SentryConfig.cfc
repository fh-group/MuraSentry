/*
  Alexander Ambrose
  fh group (2013)
  http://www.fh-group.com/

  This work is licensed under a Creative Commons Attribution-Share-Alike 3.0
  Unported License.

  Default configuration for MuraSentry.
*/
component accessors=true {

  // Sentry DSN
  property name='Sentry_DSN'         type='string' default='';

  // Sentry Public Key
  property name='Sentry_Public_Key'  type='string' default='';

  // Sentry Private Key
  property name='Sentry_Private_Key' type='string' default='';

  // Sentry Project ID
  property name='Sentry_Project_ID'  type='string' default='';

  // Sentry Server
  property name='Sentry_Server'      type='string' default='';

  public function init(string dsn)
  {
    writeDump(this);
    this.Sentry_DSN = arguments.dsn;

    var parsedDSN = parseUri(this.Sentry_DSN);

    this.Sentry_Public_Key = parsedDSN.user;
    this.Sentry_Private_Key = parsedDSN.password;
    this.Sentry_Project_ID = ListLast(parsedDSN.directory, "/");
    this.Sentry_Server = parsedDSN.host;
  }

  public struct function getRavenConfiguration(){
    var config = StructNew();

    config.publicKey = this.Sentry_Public_Key;
    config.privateKey = this.Sentry_Private_Key;
    config.sentryUrl = this.Sentry_Server;
    config.projectID = this.Sentry_Project_ID;

    return config;
  }

  // parseUri CF v0.2, by Steven Levithan: http://stevenlevithan.com
  public struct function parseUri(string sourceUri) {
    var uriPartNames = listToArray("source,protocol,authority,userInfo,user,password,host,port,relative,path,directory,file,query,anchor");
    var uriParts = reFind("^(?:(?![^:@]+:[^:@/]*@)([^:/?##.]+):)?(?://)?((?:(([^:@]*):?([^:@]*))?@)?([^:/?##]*)(?::(\d*))?)(((/(?:[^?##](?![^?##/]*\.[^?##/.]+(?:[?##]|$)))*/?)?([^?##/]*))(?:\?([^##]*))?(?:##(.*))?)", sourceUri, 1, TRUE);
    var uri = StructNew();
    var i = 1;

    /*
    Add the following keys to the uri struct:
    - source (the full, original URI)
    - protocol (scheme)
    - authority (includes the userInfo, host, and port parts)
      - userInfo (includes the user and password parts)
        - user
        - password
      - host (can be an IP address)
      - port
    - relative (includes the path, query, and anchor parts)
      - path (includes both the directory path and filename)
        - directory (supports directories with periods, and without a trailing backslash)
        - file
      - query (does not include the leading question mark)
      - anchor (fragment)
    */
    for( i = 1; i <= 14; i++){
      /*
      If the part was found in the source URI...
      - The arrayLen() check is needed to prevent a CF error when sourceUri is empty, because due to an apparent bug,
        reFind() does not populate backreferences for zero-length capturing groups when run against an empty string
        (though it does still populate backreference 0).
      - The pos[i] value check is needed to prevent a CF error when mid() is passed a start value of 0, because of
        the way reFind() considers an optional capturing group that does not match anything to have a pos of 0.
      */

      if( ArrayLen(uriParts.pos) > 1 && uriParts.pos[i] > 0){
        uri[uriPartNames[i]] = mid(sourceUri, uriParts.pos[i], uriParts.len[i]);
      }else{
        uri[uriPartNames[i]] = "";
      }
    }

    /* Always end directory with a trailing backslash if a path was present in the source URI.
    Note that a trailing backslash is NOT automatically inserted within or appended to the relative or path parts */
    if( len(uri.directory) > 0){
      uri.directory = reReplace(uri.directory, "/?$", "/");
    }

    return uri;
  }
}
